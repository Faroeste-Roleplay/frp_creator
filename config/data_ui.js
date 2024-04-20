function getDataCreator(){
    return uiMenuData
}

const uiMenuData = {
    mainMenu:[
        {
            title: "Personagem",
            subTitle: "Menu Principal",
            inputs: 
            [
                { name: "Nome Completo", subTitle: 'Escreva o nome do seu Personagem aqui.', id: "name", type: "button", sendTo: 'name', value:"Nome Completo" },
                { name: "Idade", subTitle: 'Idade do seu personagem', id: "age-old", type: "number", minValue: 16, maxValue: 120, value: 28, steps: 1, disabled: true},
                { name: "Aparencia", subTitle: 'Personalizar a Aparência do personagem.', id: "appearance", type: "button", value: null, sendTo: "creatorMenu", focusedMenuIndex: 0, disabled: true },
                { name: "Roupas", subTitle: 'Personalizar as Roupas do personagem.', id: "clothes", type: "button", value: null, sendTo: 'clothesMenu', focusedMenuIndex: 0, disabled: true},
                { name: "Confirmar", subTitle: 'Confirmar seu personagem.', id: "confirm", type: "button", value: null, sendTo: 'confirm', disabled: true },
            ]
        },
    ],
    creatorMenu: [                
        {   
            title: "Aparência",
            subTitle: "Opções",
            menuReturn: "mainMenu",
            inputs: 
            [
                { name: "Cabeça", subTitle: 'Selecione o base de sua aparência.', id: "heads", type: "number", minValue: 1, maxValue: 20, value: 1, steps: 1 },                        
                { name: "Deformações", subTitle: 'Deformações e marcas no rosto', id: "ageing", type: "number",  typeOfOverlay: 'model', minValue: 1, maxValue: 25, value: 1, steps: 1},
                { name: "Largura Cabeça", subTitle: 'Modifique a largura da cabeça', id: "face_width", type: "number", minValue: -1.9,hashFeacture: 0x84D6, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Pele [Tipo]", subTitle: 'Selecione seu tipo de pele.', id: "BODIES_UPPER", type: "number", minValue: 1, value: 1, maxValue: 5, steps: 1 },
                { name: "Cor da pele", subTitle: 'Selecione seu tom de pele.', id: "skin_tone", type: "number", minValue: 1, value: 1, maxValue: 6, steps: 1 },                         
                { name: "Estrutura corporal", subTitle: 'Selecione a esturura corporal.', id: "porte", type: "number", minValue: 1, value: 1, maxValue: 5, steps: 1 },                                          
                { name: "Gordura corporal", subTitle: 'Selecione a gordura corporal.', id: "char-weight", type: "number", minValue: 1, value: 11, maxValue: 21, steps: 1 },                      
                { name: "Altura", id: "pedSize", subTitle: 'Selecione a altura de seu personagem.', type: "number", minValue: 150, value: 185, maxValue: 200, steps: 1.0 },
                { name: "Rosto", id: "face", subTitle: 'Personalizar o rosto de seu personagme.', type: "button", value: null, focusedMenuIndex: 2    },
            //    { name: "Maquiagem", id: "face", subTitle: 'Personalizar o rosto de seu personagme.', type: "button", value: null, focusedMenuIndex: 14    },
                { name: "Cabelo", id: "hair", subTitle: 'Personalizar o Cabelo e barba.', type: "button", value: null, focusedMenuIndex: 1 },
            ]
        },
        {   
            title: "Cabelo",
            subTitle: "Opções",
            return: 0,
            inputs: 
            [
              //  { name: "Marca do cabelo", subTitle: 'Selecione o tipo de Marca do cabelo.', id: "hairov", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 4, steps: 1 },                    
              //  { name: "Cor", subTitle: 'Selecione a cor da Marca do cabelo.', id: "hairov_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Cabelo", subTitle: 'Selecione o cabelo.', id: "hair", type: "number", minValue: 0, value: 0, maxValue: 28, steps: 1 },
                { name: "Cor do Cabelo", subTitle: 'Modifique a cor do cabelo.', id: "hair-color", type: "number", minValue: 1, value: 1, maxValue: 15, steps: 1 },
                
              //  { name: "Marcas da barba", subTitle: 'Selecione o tipo de Marcas da barba.', id: "beardstabble", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 },                    
              //  { name: "Cor", subTitle: 'Selecione a cor da Marcas da barba.', id: "beardstabble_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Barba", subTitle: 'Selecione a barba.', id: "mustache", type: "number", minValue: 0, value: 0,  maxValue: 29, steps: 1},
                { name: "Cor da Barba", subTitle: 'Modifique a cor da barba.', id: "mustache-color", type: "number", minValue: 1, value: 0,  maxValue: 15, steps: 1},
            ]
        }, 
        {   
            title: "Rosto",
            subTitle: "Opções",
            return: 0,
            inputs: 
            [                        
                { name: "Manchas e Marcas", subTitle: 'Personalizar manchas e marcas nos rosto.', id: "scars", type: "button", value: null, focusedMenuIndex: 3 },
                { name: "Boca", subTitle: 'Personalizar a boca.', id: "mouth", type: "button", value: null, focusedMenuIndex: 8 },
                { name: "Olhos", subTitle: 'Personalizar os olhos.', id: "eye", type: "button", value: null, focusedMenuIndex: 4 },
                { name: "Sobrancelha", subTitle: 'Personalizar as sobrancelhas.', id: "eyebrow", type: "button", value: null, focusedMenuIndex: 5 },
                { name: "Orelha", subTitle: 'Personalizar as orelhas.', id: "ear", type: "button", value: null, focusedMenuIndex: 6 },
                { name: "Nariz", subTitle: 'Personalizar o nariz.', id: "nose", type: "button", value: null, focusedMenuIndex: 7 },
                { name: "Queixo", subTitle: 'Personalizar o queixo.', id: "chin", type: "button", value: null, focusedMenuIndex: 9 },
                { name: "Mandíbula", subTitle: 'Personalizar a mandíbula.', id: "jaw", type: "button", value: null, focusedMenuIndex: 10 },
                { name: "Bochecha", subTitle: 'Personalizar a bochecha.', id: "cheekbone", type: "button", value: null, focusedMenuIndex: 11 },
            ]
        },
        {
            title: "Manchas e Marcas",
            return: 2,
            subTitle: "Opções",
            inputs:
            [                                         
                { name: "Cicatrizes", subTitle: 'Selecione o tipo de Cicatrizes.', id: "scars", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 16, steps: 1 },                    
                { name: "Espinhas", subTitle: 'Selecione o tipo de Espinhas.', id: "acne", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 }, 
                { name: "Manchas", subTitle: 'Selecione o tipo de Manchas.', id: "complex", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 14, steps: 1 }, 
                { name: "Tampão", subTitle: 'Selecione o tipo de Tampão.', id: "disc", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 16, steps: 1 }, 
                { name: "Sardas", subTitle: 'Selecione o tipo de Sardas.', id: "freckles", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 15, steps: 1 },  
                { name: "Sujeira", subTitle: 'Selecione o tipo de Sujeira.', id: "grime", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 16, steps: 1 },  
                { name: "Verugas", subTitle: 'Selecione o tipo de Verugas.', id: "moles", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 16, steps: 1 }, 
                { name: "Queimadura", subTitle: 'Selecione o tipo de Queimadura.', id: "spots", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 16, steps: 1 }, 
            ]
        }, 
        {
            title: "Olhos",
            return: 2,
            subTitle: "Opções",
            inputs:
            [                     
                { name: "Olhos", subTitle: 'Selecione o tipo de olho.',  id: "eyes", type: "number", minValue: 0, value: 1, maxValue: 14, steps: 1 },
                { name: "Palpebra L", subTitle: 'Modifique a largura da palpebra.',  id: "eyelid_width", type: "number", minValue: -1.9,hashFeacture: 0x1B6B, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Palpebra A", subTitle: 'Modifique a altura da palpebra.', id: "eyelid_height", type: "number", minValue: -1.9,hashFeacture: 0x8B2B, value: 0, maxValue: 1.9, steps: 0.1 },                    

                { name: "Profundidade", subTitle: 'Modifique a profundidade dos olhos.', id: "eyes_depth", type: "number", minValue: -1.9,hashFeacture: 0xEE44, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Distância", subTitle: 'Modifique a distância dos olhos.', id: "eyes_distance", type: "number", minValue: -1.9,hashFeacture: 0xA54E, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Angulo", subTitle: 'Modifique o ângulo dos olhos.', id: "eyes_angle", type: "number", minValue: -1.9,hashFeacture: 0xD266, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique o altura dos olhos.', id: "eyes_height", type: "number", minValue: -1.9,hashFeacture: 0xDDFB, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },  
        {
            title: "Sobrancelhas",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Tipo", subTitle: 'Selecione o tipo de sobrancelha.', id: "eyebrows", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 24, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da sobrancelha.', id: "eyebrows", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 },                      
                { name: "Profundidade", subTitle: 'Modifique a profundidade da sobrancelha.', id: "eyebrow_depth", type: "number", minValue: -1.9,hashFeacture: 0x4AD1, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura da sobrancelha.', id: "eyebrow_width", type: "number", minValue: -1.9,hashFeacture: 0x2FF9, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura da sobrancelha.', id: "eyebrow_height", type: "number", minValue: -1.9,hashFeacture: 0x3303, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },  
        {
            title: "Orelhas",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Tamanho", subTitle: 'Modifique o tamanho das orelhas.', id: "earlobe_size", type: "number", minValue: -1.9,hashFeacture: 0xED30, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Ângulo", subTitle: 'Modifique o ângulo das orelhas.', id: "ears_angle", type: "number", minValue: -1.9,hashFeacture: 0xB6CE, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura das orelhas.', id: "ears_width", type: "number", minValue: -1.9,hashFeacture: 0xC04F, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique o altura das orelhas.', id: "ear_height", type: "number", minValue: -1.9,hashFeacture: 0x2844, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },  
        {
            title: "Nariz",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Tamanho", subTitle: 'Modifique o tamanho do nariz.', id: "nose_size", type: "number", minValue: -1.9,hashFeacture: 0x3471, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Ângulo", subTitle: 'Modifique o ângulo do nariz.', id: "nose_angle", type: "number", minValue: -1.9,hashFeacture: 0x34B1, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura do nariz.', id: "nose_width", type: "number", minValue: -1.9,hashFeacture: 0x6E7F, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura do nariz.', id: "nose_height", type: "number", minValue: -1.9,hashFeacture: 0x03F5, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Curvatura", subTitle: 'Modifique a curvatura do nariz.', id: "nose_curvature", type: "number", minValue: -1.9, hashFeacture: 0xF156, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Narina", subTitle: 'Modifique a distância das narinas.', id: "nostrils_distance", type: "number", minValue: -1.9,hashFeacture: 0x561E, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },  
        {
            title: "Boca",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Dentes", subTitle: 'Escolha a arcada dentária.', id: "teeth", type: "number", minValue: 1, value: 1, maxValue: 7, steps: 1 },                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade da boca.', id: "mouth_depth", type: "number", minValue: -1.9, hashFeacture: 0xAA69, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura da boca.', id: "mouth_width", type: "number", minValue: -1.9,   hashFeacture: 0xF065, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Pos. Horizontal", subTitle: 'Modifique a posição horizontal da boca.', id: "mouth_x_pos", type: "number", minValue: -1.9,    hashFeacture: 0x7AC3, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Pos. Vertical", subTitle: 'Modifique a posição vertical da boca.', id: "mouth_y_pos", type: "number", minValue: -1.9,    hashFeacture: 0x410D, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Lábio Inferior", subTitle: 'Personalizar o lábio inferior.', id: "lip_lower", type: "button", value: null, focusedMenuIndex: 12 },
                { name: "Lábio Supeiror", subTitle: 'Personalizar o lábio superior.', id: "lip_upper", type: "button", value: null, focusedMenuIndex: 11 },
            ]
        },  
        {
            title: "Queixo",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade do queixo.', id: "chin_depth", type: "number", minValue: -1.9,hashFeacture: 0xE323, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura do queixo.', id: "chin_width", type: "number", minValue: -1.9,hashFeacture: 0xC3B2, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura do queixo.', id: "chin_height", type: "number", minValue: -1.9,hashFeacture: 0x3C0F, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },
        {
            title: "Mandíbula",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade da mandíbula.', id: "jaw_depth", type: "number", minValue: -1.9,hashFeacture: 0x1DF6, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura da mandíbula.',  id: "jaw_width", type: "number", minValue: -1.9,hashFeacture: 0xEBAE, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura da mandíbula.',  id: "jaw_height", type: "number", minValue: -1.9,hashFeacture: 0x8D0A, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },
        {
            title: "Bochecha",
            subTitle: "Opções",
            return: 2,
            inputs:
            [                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade da bochecha.', id: "cheekbones_depth", type: "number", minValue: -1.9,hashFeacture: 0x358D, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura da bochecha.',  id: "cheekbones_width", type: "number", minValue: -1.9,hashFeacture: 0xABCF, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura da bochecha.',  id: "cheekbones_height", type: "number", minValue: -1.9,hashFeacture: 0x6A0B, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        }, 
        {
            title: "Lábio Superior",
            subTitle: "Opções",
            return: 8,
            inputs:
            [                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade do lábio superior.', id: "upper_lip_depth", type: "number", minValue: -1.9,hashFeacture: 0xC375, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura do lábio superior.', id: "upper_lip_width", type: "number", minValue: -1.9,hashFeacture: 0x91C1, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura do lábio superior.', id: "upper_lip_height", type: "number", minValue: -1.9,hashFeacture: 0x1A00, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        }, 
        {
            title: "Lábio Inferior",
            subTitle: "Opções",
            return: 8,
            inputs:
            [                     
                { name: "Profundidade", subTitle: 'Modifique a profundidade do lábio inferior.', id: "lower_lip_depth", type: "number", minValue: -1.9,hashFeacture: 0x5D16, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Largura", subTitle: 'Modifique a largura do lábio inferior.', id: "lower_lip_width", type: "number", minValue: -1.9,hashFeacture: 0xB0B0, value: 0, maxValue: 1.9, steps: 0.1 },                    
                { name: "Altura", subTitle: 'Modifique a altura do lábio inferior.', id: "lower_lip_height", type: "number", minValue: -1.9,hashFeacture: 0xBB4D, value: 0, maxValue: 1.9, steps: 0.1 },                    
            ]
        },
        {
            title: "Maquiagens",
            return: 2,
            subTitle: "Opções",
            inputs:
            [                                         
                { name: "Delineador", subTitle: 'Selecione o tipo de Delineador.', id: "eyeliners", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da Delineador.', id: "eyeliners_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Baton", subTitle: 'Selecione o tipo de Baton.', id: "lipsticks", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da Baton.', id: "lipsticks_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 },

                { name: "Sombras", subTitle: 'Selecione o tipo de Sombras.', id: "shadows", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da Sombras.', id: "shadows_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Mascara Pintada", subTitle: 'Selecione o tipo de Mascara Pintada.', id: "paintedmasks", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 1.9, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da Mascara Pintada.', id: "paintedmasks_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Blush", subTitle: 'Selecione o tipo de Blush.', id: "blush", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 30, steps: 1 },                    
                { name: "Cor", subTitle: 'Selecione a cor da Blush.', id: "blush_color", type: "number", typeOfOverlay: 'color', minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

                { name: "Base", subTitle: 'Selecione o tipo de Base.', id: "foundation", type: "number", typeOfOverlay: 'model', minValue: 0, value: 0, maxValue: 30, steps: 1 },             
                { name: "Cor", subTitle: 'Selecione a cor da Base.', id: "foundation_color", type: "number", typeOfOverlay: "color", minValue: 0, value: 0, maxValue: 30, steps: 1 }, 

            ]
        }
    ],
    clothesMenu: [                
        {   
            title: "Aparência",
            subTitle: "Opções",
            menuReturn: "mainMenu",
            inputs: 
            [
                { name: "Chapéu", subTitle: 'Escolha um chapéu.', id: "hats", type: "number", minValue: 0, maxValue: 5, value: 1, steps: 1 },                        
                { name: "Camisa", subTitle: 'Escolha uma camisa.', id: "shirts_full", type: "number", minValue: 0, maxValue: 5, value: 1, steps: 1},
                { name: "Calça", subTitle: 'Escolha uma calça', id: "pants", type: "number", minValue: 0, value: 1, maxValue: 5, steps: 1 },                    
                { name: "Calçado", subTitle: 'Escolha um calçado.', id: "boots", type: "number", minValue: 0, value: 1, maxValue: 5, steps: 1 }
            ]
        },
    ]
}